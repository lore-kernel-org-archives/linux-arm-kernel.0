From: Yuval.Mintz@qlogic.com (Yuval Mintz)
Date: Sun, 22 Nov 2015 08:49:49 +0000
Subject: [PATCH V3 net-next 3/5] net:hns: Add Hip06 "TSO(TCP Segment
 Offload)" support HNS Driver
In-Reply-To: <1447966706-16219-4-git-send-email-salil.mehta@huawei.com>
References: <1447966706-16219-1-git-send-email-salil.mehta@huawei.com>
 <1447966706-16219-4-git-send-email-salil.mehta@huawei.com>
Message-ID: <CO2PR11MB00885067453FB6462178765497180@CO2PR11MB0088.namprd11.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static void hns_ae_set_tso_stats(struct hnae_handle *handle, int
> +enable) {
> +	struct hns_ppe_cb *ppe_cb = hns_get_ppe_cb(handle);
> +
> +	hns_ppe_set_tso_enable(ppe_cb, enable); }

Style issues?

> +void hns_ppe_set_tso_enable(struct hns_ppe_cb *ppe_cb, u32 value) {
> +	dsaf_set_dev_bit(ppe_cb, PPEV2_CFG_TSO_EN_REG, 0, !!value); }
> +

Likewise

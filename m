From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Mon, 1 Aug 2016 00:41:52 +0800
Subject: [PATCH] net: thunderx: correct bound check in nic_config_loopback
In-Reply-To: <1469933384-16827-1-git-send-email-alexander.levin@verizon.com>
References: <1469933384-16827-1-git-send-email-alexander.levin@verizon.com>
Message-ID: <CA+sq2Cc-MTtoncAcL6MS-YVdeVVK=aqEmZakzkX6_CwsXvpRCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for finding.
A much better fix would be,

-       if (lbk->vf_id > MAX_LMAC)
+       if (lbk->vf_id >= nic->num_vf_en)
                return -1;

where 'num_vf_en' reflects the exact number of physical interfaces or
LMACs on the system.

Thanks,
Sunil.

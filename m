From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 13 Dec 2013 14:04:54 +0800
Subject: [PATCH v6 06/15] usb: phy-mxs: Add anatop regmap
In-Reply-To: <20131213042627.GF867@saruman.home>
References: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
 <1386897825-6130-7-git-send-email-peter.chen@freescale.com>
 <20131213042627.GF867@saruman.home>
Message-ID: <CAL411-peWM-dpdWDvR2KX9tBGK2tkhwZTWvyLbYevpA6-9rNRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 12:26 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Fri, Dec 13, 2013 at 09:23:36AM +0800, Peter Chen wrote:
>> @@ -226,6 +235,16 @@ static int mxs_phy_probe(struct platform_device *pdev)
>>
>>       platform_set_drvdata(pdev, mxs_phy);
>>
>> +     if (mxs_phy->data->flags & MXS_PHY_HAS_ANATOP) {
>
> instead of the flag, you can check if that binding exist and use the
> binding itself as a flag.
>

If flag MXS_PHY_HAS_ANATOP is existed, that binding must need to be
existed, or it is an error.  syscon_regmap_lookup_by_phandle will return
error is the binding is not existed.

-- 
BR,
Peter Chen

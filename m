From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Thu, 28 Apr 2011 12:52:49 +0530
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <4DB81B9E.3000401@pengutronix.de>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-2-git-send-email-subhasish@mistralsolutions.com>
	<4DB1A603.2090208@pengutronix.de>
	<EDC1056430EF4DA8A0D850CE1DEA28FC@subhasishg>
	<4DB7C5F7.3080103@pengutronix.de>
	<20110427091252.GP17290@n2100.arm.linux.org.uk>
	<5BAE2D6F9E6047C19B6BE8FF26F7270B@subhasishg>
	<4DB81B9E.3000401@pengutronix.de>
Message-ID: <8430D2C750334C98B8E8D1469F2023C7@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/27/2011 03:18 PM, Subhasish Ghosh wrote:
> My problem is, I am doing something like this:
>
> s32 pruss_writel_multi(struct device *dev, u32 offset,
>                u32 *pdatatowrite, u16 wordstowrite)
> {
>        struct pruss_priv *pruss = dev_get_drvdata(dev->parent);
>        u32 __iomem *paddresstowrite;
>        u16 i;
>
>        paddresstowrite = pruss->ioaddr + offset;
>
>        for (i = 0; i < wordstowrite; i++)
>                iowrite32(*pdatatowrite++, paddresstowrite++);
>
>        return 0;
> }
>
> So, if I make paddresstowrite as void, it will not work. The above
> implementation does not generate any sparse errors though.

Yes, that why I can work with readb_multi even if I have void __iomen *.

But, how do I solve this problem. In the above function, I must use u32 
__iomem * 

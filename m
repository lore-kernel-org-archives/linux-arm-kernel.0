From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 04 Sep 2014 08:52:47 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0gbWZkOiBzeXNjb246IERlY291cGxlIHN5c2NvbiBp?=
 =?UTF-8?B?bnRlcmZhY2UgZnJvbSBwbGF0Zm9ybSBkZXZpY2Vz?=
In-Reply-To: <002601cfc7fa$39413580$abc3a080$@samsung.com>
References: <1409668935-10667-1-git-send-email-pankaj.dubey@samsung.com>
 <6034841.GFrG3XCMdb@wuerfel>
 <002601cfc7fa$39413580$abc3a080$@samsung.com>
Message-ID: <1409806367.933281809@f338.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thu, 04 Sep 2014 10:09:19 +0530 ?? Pankaj Dubey <pankaj.dubey@samsung.com>:
> Hi Arnd,
> 
> On Tuesday, September 02, 2014 Arnd Bergmann wrote,
> > To: Pankaj Dubey
> > Cc: linux-arm-kernel at lists.infradead.org;
> linux-samsung-soc at vger.kernel.org; linux-
> > kernel at vger.kernel.org; lee.jones at linaro.org; kgene.kim at samsung.com;
> > linux at arm.linux.org.uk; vikas.sajjan at samsung.com; joshi at samsung.com;
> > naushad at samsung.com; thomas.ab at samsung.com; chow.kim at samsung.com;
> > tomasz.figa at gmail.com; Tomasz Figa; Alexander Shiyan; Michal Simek
> > Subject: Re: [PATCH v2] mfd: syscon: Decouple syscon interface from
> platform
> > devices
...
> > > -struct regmap *syscon_regmap_lookup_by_pdevname(const char *s) -{
> > > -	struct device *dev;
> > > -	struct syscon *syscon;
> > > -
> > > -	dev = driver_find_device(&syscon_driver.driver, NULL, (void *)s,
> > > -				 syscon_match_pdevname);
> > > -	if (!dev)
> > > -		return ERR_PTR(-EPROBE_DEFER);
> > > -
> > > -	syscon = dev_get_drvdata(dev);
> > > -
> > > -	return syscon->regmap;
> > > -}
> > > -EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_pdevname);
> > 
> > I think this can actually be left intact if that helps with clps71xx.
> > It could be done in a hacky way using bus_find_device_by_name() to keep it
> simple,
> > or in a somewhat nicer way by keeping the syscon platform_driver around
> for the
> > non-DT case.
> > 
> 
> Ok as per our last discussion you mentioned that clps71xx will be soon
> migrating to DT.
> So if that is not going to happen sooner, I would also prefer better keep
> syscon_regmap_lookup_by_pdevname and syscon platform_driver for non-DT case,
> so that this issue should not block this patch.
> 
> So please let's make final call to keep syscon platform_driver for non-DT
> case which eventually
> can be dropped once clps71xx driver migrates to DT based. So that I can
> prepare next patchset
> keeping syscon platform_driver support  and syscon_regmap_lookup_by_pdevname
> API support
> for non-DT case and send across for review. 

Arnd, can you force the applying of the latest clps711x patches to accelerate the process?
I mean latest 3 arm-soc patches from Aug, 19.
After that I will need to make a patch for the SPI and TTY subsystems, then initial DT
support will be introduced.

---

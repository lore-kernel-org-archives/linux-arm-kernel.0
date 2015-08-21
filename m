From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Aug 2015 16:00:35 +0200
Subject: =?UTF-8?B?562U5aSNOg==?= [PATCH 1/5] net: add Hisilicon Network
 Subsystem support (config and documents)
In-Reply-To: <161EFA05D917D0419F95C4CAEEF86C1094E95FAA@SZXEMA504-MBS.china.huawei.com>
References: <1439548222-231611-1-git-send-email-liguozhu@hisilicon.com>
 <1536926.jEJjsM70Lj@wuerfel>
 <161EFA05D917D0419F95C4CAEEF86C1094E95FAA@SZXEMA504-MBS.china.huawei.com>
Message-ID: <2543796.7JthO5WCfI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 August 2015 01:28:07 Liguozhu wrote:
> Thanks, Arnd. 
> 
> Regarding the ae-name: it is the name of the Acceleration Engine. It is provided
> by the BIOS according to the position and the feature enabled of the IP.
> So "soc0" means it is on SoC No. 0, while "n4" means it is running on 
>"Non-dsaf mode 4". Ideally, we should setup the rule to name it. But as I
> said in the patchset, the IP is original designed for a bare metal solution,
> it is worthless to export all modes and we are planning to add more mode
> for Linux itself in the IP in future version. So I think the better way is
> to leave it as a "name" but add more meaning in the future.

The name property is a bit awkward. The position is normally implied by
the location of the parent device in the DT, so you should not need that
at all and instead derive it elsewhere. You can also add strings to the
compatible property instead of this, to signify differences in the programming
that are based on how the IP block is used.
 
> Regarding the ae-opts: it is the initial value for the AE's runtime options,
> Currently, we have only "port number" (there are 6XGE+2GE port for a DSAF AE)
> as option. But for future version, we will add other options such as "enable
> Spanning Tree Protocol algorithm)" and so on. 

I think these can easily be converted into an index property and boolean
flags (present if true, absent otherwise) for additional features.
 
> Should I add these background to somewhere?

The binding document needs to list all supported configurations, if you
have a string property, describe specifically what strings are allowed
and what they mean, but better try to avoid strings altogether.

	Arnd

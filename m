From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jun 2018 21:33:36 +0100
Subject: [PATCHv4 4/4] ARM: versatile: support configuring versatile
 machine for no-MMU
In-Reply-To: <TY1PR01MB1562F7C31AF6AFC4A1BBA1748A750@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <nycvar.YSQ.7.76.1806211212010.16670@knanqh.ubzr>
 <20180622110145.GU17671@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1806221110140.16670@knanqh.ubzr>
 <CAMuHMdWZPM3Q9fVXWiw1bMVWNRCYGoQa-XukJka-2xsP-=HmVQ@mail.gmail.com>
 <nycvar.YSQ.7.76.1806221146140.16670@knanqh.ubzr>
 <TY1PR01MB15624342267F973525BF45698A750@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <nycvar.YSQ.7.76.1806221244490.16670@knanqh.ubzr>
 <TY1PR01MB1562C54E8DD3942F40F8CBBD8A750@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <20180622183838.GZ17671@n2100.armlinux.org.uk>
 <TY1PR01MB1562F7C31AF6AFC4A1BBA1748A750@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Message-ID: <20180622203336.GA17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 08:25:06PM +0000, Chris Brandt wrote:
> On Friday, June 22, 2018, Russell King - ARM Linux wrote:
> > > There are configs options today that you can select, but unless some
> > > external criteria is  met during build time, the build will fail (like
> > > with a "missing .h file" message or something)
> > 
> > Such as?  I don't think that's found by the randconfig builders - I've
> > never noticed any such failures on ARM.
> 
> I got this set once by accident after a kernel update
> 
>    CONFIG_SYSTEM_TRUSTED_KEYRING=y
> 
> which then let me to this error:
> 
>   HOSTCC  scripts/extract-cert
> ../scripts/extract-cert.c:21:25: fatal error: openssl/bio.h: No such file or directory
> compilation terminated.

Hmm.  Is that a problem if the documented minimum requirements to build
the kernel are violated?  It seems the openssl 1.0.0 development package
is required to build kernels v4.3 and beyond.

Here's what Documentation/process/changes.rst has to say about it:

Current Minimal Requirements
****************************
...
====================== ===============  ========================================
        Program        Minimal version       Command to check the version
====================== ===============  ========================================
openssl & libcrypto    1.0.0            openssl version
...
OpenSSL
-------

Module signing and external certificate handling use the OpenSSL program and
crypto library to do key creation and signature generation.

You will need openssl to build kernels 3.7 and higher if module signing is
enabled.  You will also need openssl development packages to build kernels 4.3
and higher.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

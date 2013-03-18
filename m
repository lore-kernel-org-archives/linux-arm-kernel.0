From: wd@denx.de (Wolfgang Denk)
Date: Mon, 18 Mar 2013 20:51:29 +0100
Subject: [RFC] Kbuild support for ARM FIT images
In-Reply-To: <20130318175746.GJ30923@n2100.arm.linux.org.uk>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130222160044.GA16357@quad.lixom.net>
 <20130318163648.GA3722@amd.pavel.ucw.cz>
 <20130318164426.GI30923@n2100.arm.linux.org.uk>
 <20130318174931.GB4230@amd.pavel.ucw.cz>
 <20130318175746.GJ30923@n2100.arm.linux.org.uk>
Message-ID: <20130318195129.D6BC22014B1@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

In message <20130318175746.GJ30923@n2100.arm.linux.org.uk> you wrote:
>
> Unfortunately, there is a fundamental problem with uImage.  It encodes
> the load address, and that is utterly incompatible with the goal of
> having a kernel image which boots on multiple platforms.

I'm not sure if you are aware that U-Boot supports uImages that can be
run from _any_ load address (using the IH_TYPE_KERNEL_NOLOAD image
type).  If anybody was willing to keep uImage support in the kernel
this would probably be a convenient way to go.

But in any case, the uImage format is deprecated.  Support for FIT
images was added more than five years ago, and new developments should
rather focus on supporting these.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de

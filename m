From: wd@denx.de (Wolfgang Denk)
Date: Thu, 22 Sep 2011 15:57:02 +0200
Subject: booting single uImage on platforms with different base addresses
	for SDRAM
In-Reply-To: <20110922110411.GD20444@tbergstrom-lnx.Nvidia.com>
References: <20110922110411.GD20444@tbergstrom-lnx.Nvidia.com>
Message-ID: <20110922135702.EE2731407978@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peter De Schrijver,

In message <20110922110411.GD20444@tbergstrom-lnx.Nvidia.com> you wrote:
> Hi,
> 
> Currently uImages have the load address hardcoded. As we now try to support
> as many ARM platforms as possible with a single binary, this becomes a
> problem. On tegra20 SDRAM starts at physical address 0, but on tegra30 SDRAM
> starts at 0x80000000. It's possible to build a kernel image which can deal
> with this, but the uImage still uses a hardcoded address. This results
> in requiring 2 different uImages even though the zImage is the same.
> 
> Has anyone thought of a solution to this problem?

Yes, this has been discussed before.  I proposed to allow for an
offset specification instead of an absolute address.  After that, the
discussions faded.  No code has been submitted yet.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
"Never give in.  Never give in.  Never. Never. Never."
- Winston Churchill

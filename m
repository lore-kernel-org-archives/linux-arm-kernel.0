From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 3 May 2016 14:45:40 -0700
Subject: [PATCH 0/3] Fixup Broadcom CPU enable method
In-Reply-To: <1461866399-1725-1-git-send-email-chris.brand@broadcom.com>
References: <1461866399-1725-1-git-send-email-chris.brand@broadcom.com>
Message-ID: <57291C04.9010300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/04/16 10:59, Chris Brand wrote:
> This is preparation for supporting the quad-core BCM23550 chip.
> 
> Documentation/devicetree/bindings/arm/cpus.txt states that "enable-method"
> should be a property of the "cpu" node rather than the "cpus" node.
> 
> Commit 84320e1a635fcf90cff4185f029ce9e31bf1d4a7
> ("ARM: BCM: Clean up SMP support for Broadcom Kona") moved the 
> "secondary-boot-reg" property from the "cpus" node to the individual "cpu"
> nodes but negelected to actually support multiple "secondary-boot-reg"
> properties.
> 
> This patchset moves the enable-method property to the correct place,
> adds the missing enable-method to the binding documentation, and actually
> supports setting the "enable-method" property on multiple CPU nodes.
> 
> Without this change, "secondary-boot-reg" on even-numbered CPUs is ignored,
> and the value specified on the last odd-numbered CPU to be processed
> overrides any earlier values.
> 
> Behaviour is slightly changed by this patchset, in that the
> "secondary-boot-reg" property is only examined when the CPU is being enabled.
> This means that the omission of that property will be reported slightly later,
> or never if the CPU in question is never brought online. It also means that
> the omission in one CPU has no effect on other CPUs, whereas previously
> omitting it from one CPU would force the system into single-core mode.

Series applied to devicetree/next, thanks Chris!
-- 
Florian

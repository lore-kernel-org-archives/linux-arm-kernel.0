From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Mon, 25 Nov 2013 15:41:10 +0000
Subject: ACPI
In-Reply-To: <CACxGe6vUKzow7QpeX2mU7CiZQzY8aZ+p0jd8Vk0+dqz0B=D0Ew@mail.gmail.com>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <CACRpkdbNxxNK0GM28H_nDLu6EpbQ-EYAdEeTp5fnXW5mkEPkgw@mail.gmail.com>
 <CACxGe6uHuWPh7d9NaVuPRBWq0Fh1BmDV190KEN4C4uaq4KjS8g@mail.gmail.com>
 <CACRpkdaCXJzWXoesjD3Jqpm4XMHLQp3SsHcsDG3veUS+xarqHQ@mail.gmail.com>
 <CACxGe6vUKzow7QpeX2mU7CiZQzY8aZ+p0jd8Vk0+dqz0B=D0Ew@mail.gmail.com>
Message-ID: <20131125154110.GB3243@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 11:33:56AM +0000, Grant Likely wrote:

> What I'm assuming here is that on ACPI the pinctrl setup and
> management would be performed by the platform in AML methods so that
> the kernel isn't aware of them at all. All it know is that it has a
> (for example) SPI bus and as far as it is concerned the pins are
> correctly attached when the SPI bus is active. My understanding is
> that historically this is how ACPI has been used.

Pretty much. In the past ACPI implementations handled GPIO by providing 
methods that accessed hardware registers directly. I've seen DSDTs that 
implement i2c entirely in ASL. It's *very* common for hwmon devices to 
be hidden away behind some ACPI methods.

The obvious downside of this approach is that there's no real mechanism 
for allowing a real driver to access the hardware at the same time as 
the ACPI code, and as a consequence you're limited to whatever 
functionality is provided by the ACPI code.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org

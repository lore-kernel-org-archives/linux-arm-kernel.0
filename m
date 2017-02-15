From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Feb 2017 20:07:32 +0000
Subject: [PATCH v2 0/5] ARM: add module autoloading support for crypto
 modules
In-Reply-To: <CAKv+Gu9b92hKiN0nyKEdjkszUzPVf3ODt7wtiqdLwnkrdhsyvA@mail.gmail.com>
References: <1484154118-22139-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170215200002.GF27312@n2100.armlinux.org.uk>
 <CAKv+Gu9b92hKiN0nyKEdjkszUzPVf3ODt7wtiqdLwnkrdhsyvA@mail.gmail.com>
Message-ID: <20170215200732.GG27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 08:04:07PM +0000, Ard Biesheuvel wrote:
> On 15 February 2017 at 20:00, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Wed, Jan 11, 2017 at 05:01:53PM +0000, Ard Biesheuvel wrote:
> >> This series wires up the crypto modules that use the ARM 32-bit versions of
> >> the ARMv8 Crypto Extensions to udev autoloading, by exposing the HWCAP2
> >> feature bits via the CPU modalias. This is very similar to the arm64
> >> implementation, with the notable exception that ARM has its CPU feature
> >> definitions split across HWCAP and HWCAP2.
> >
> > Note that Aarch64 has:
> >
> > MODALIAS=cpu:type:aarch64:feature:,0000,0001,0002,0003,0004,0005,0006,0007
> >
> > which looks weird with the first numeric entry starting with a ','.
> >
> 
> IIRC this is deliberate, since the udev code matches the feature field
> for *nnnn*, which is what the module alias exposes.

I noticed, feature:*0000* matches both "feature:0000" and "feature:,0000".

> Yes, I am aware of that. But there aren't /that/ many optional
> features that lend themselves for module autoloading.

Yes.  Once we've exhausted the HWCAP2 space, we'll either have to add
HWCAP3 or finish off using the unused 11 in the HWCAP space.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

From: ak@linux.intel.com (Andi Kleen)
Date: Thu, 7 Nov 2013 13:39:44 -0800
Subject: [RFC PATCH 0/4] wire up CPU features to udev based module loading
In-Reply-To: <527C0195.50008@zytor.com>
References: <1383844657-17487-1-git-send-email-ard.biesheuvel@linaro.org>
 <527C0195.50008@zytor.com>
Message-ID: <20131107213944.GJ1962@tassilo.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 07, 2013 at 01:09:41PM -0800, H. Peter Anvin wrote:
> On 11/07/2013 09:17 AM, Ard Biesheuvel wrote:
> > This series implements automatic module loading based on optional CPU features,
> > and tries to do so in a generic way. Currently, 32 feature bits are supported,
> > and how they map to actual CPU features is entirely up to the architecture.
> 
> NAK.
> 
> We in the x86 world already left 32 bits way behind; we currently have
> 320 bit feature masks.
> 
> If you're aiming at doing this in a generic way, it needs to be able to
> accommodate the current x86cpu feature stuff as a subset, which this
> doesn't.

They can just use the exact same code/macros as x86cpu, just need a different 
prefix and use wildcards if they miss something (e.g. family)

-Andi

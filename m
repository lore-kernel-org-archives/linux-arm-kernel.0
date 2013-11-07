From: hpa@zytor.com (H. Peter Anvin)
Date: Thu, 07 Nov 2013 13:09:41 -0800
Subject: [RFC PATCH 0/4] wire up CPU features to udev based module loading
In-Reply-To: <1383844657-17487-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1383844657-17487-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <527C0195.50008@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2013 09:17 AM, Ard Biesheuvel wrote:
> This series implements automatic module loading based on optional CPU features,
> and tries to do so in a generic way. Currently, 32 feature bits are supported,
> and how they map to actual CPU features is entirely up to the architecture.

NAK.

We in the x86 world already left 32 bits way behind; we currently have
320 bit feature masks.

If you're aiming at doing this in a generic way, it needs to be able to
accommodate the current x86cpu feature stuff as a subset, which this
doesn't.

	-hpa

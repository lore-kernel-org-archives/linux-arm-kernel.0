From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 7 Dec 2017 14:26:57 +0000
Subject: [RFC v3 PATCH 0/2] Introduce Security Version to EFI Stub
In-Reply-To: <20171205100148.5757-1-glin@suse.com>
References: <20171205100148.5757-1-glin@suse.com>
Message-ID: <20171207142657.52e1363a@alans-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  5 Dec 2017 18:01:46 +0800
Gary Lin <glin@suse.com> wrote:

> The series of patches introduce Security Version to EFI stub.
> 
> Security Version is a monotonically increasing number and designed to
> prevent the user from loading an insecure kernel accidentally. The
> bootloader maintains a list of security versions corresponding to
> different distributions. After fixing a critical vulnerability, the
> distribution kernel maintainer bumps the "version", and the bootloader
> updates the list automatically. 

This seems a mindbogglingly complicated way to implement something you
could do with a trivial script in the package that updates the list of
iffy kernels and when generating the new grub.conf puts them in a menu
of 'old insecure' kernels.

Why do you even need this in the EFI stub ?

What happens if you want to invalidate an old kernel but not push a new
one ? Today if you've got a package that maintains the list of 'iffy'
kernels you can push a tiny package, under your scheme you've got to push
new kernels which is an un-necessary and high risk OS change.

It just feels like an attempt to solve the problem in completely the
wrong place.

Alan

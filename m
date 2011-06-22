From: vladoman@gmail.com (Vladimir Pantelic)
Date: Wed, 22 Jun 2011 08:57:06 +0200
Subject: Trouble with newer kernels on Gumstix Overo boards
In-Reply-To: <BANLkTim5H3340RChbaVUOpSYb4tQr9X9YA@mail.gmail.com>
References: <BANLkTimJTBpj30EKf_EucvOf2yCHHbRrkQ@mail.gmail.com>
	<ADF30F4D7BDE934D9B632CE7D5C7ACA4047B99E7E7AD@dbde03.ent.ti.com>
	<BANLkTimfeS1Xin779eg=8cdjqmqcQeB6HA@mail.gmail.com>
	<20110621072220.GA21159@atomide.com>
	<BANLkTim5H3340RChbaVUOpSYb4tQr9X9YA@mail.gmail.com>
Message-ID: <4E019242.1050503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack wrote:

> Well, it doesn't really affect me as I just use this as a development
> platform for now. But please consider that there is hardware out there
> which gets software updates through automated download and install
> procedures. In such cases, you want as little dependencies between the
> bootloader and the kernel, so you can boot both older and newer

If you want *minimal* dependency, then a compiled-in command line is
the way to go and the bootloader only providing a few board identifying
tags

> kernels (and full software distribution images) with no pain. Or maybe
> quickly switch from one version to the other for testing. Depending on
> the complexity of the system, the bootloader might also add extra
> parameters to the cmdline dynamically.

AFAIK there is way to have the bootloader provided cmdline appended
to the compiled-in one

> The serial console change breaks this approach, at it forces the
> kernel to ship its own CMDLINE and override the one the bootloader
> provides. I'm sure this is a problem that affects people out there.

FWIW, for our firmware update deployment it's not a problem at all,
since we do *not* want to rely on a kernel commandline provided by
the bootloader for the exact same reason. Kernels change and thus
the kernel command line belongs to the kernel. What does not change
is e.g. the board id or revision or mem size, that (and only that)
is provided by the bootloader to the kernel.

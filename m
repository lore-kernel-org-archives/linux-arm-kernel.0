From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 14 Mar 2017 21:08:59 +0200
Subject: [PATCH] drm/exynos: Print kernel pointers in a restricted form
In-Reply-To: <e1800491-0b60-74d1-1377-756d5b0bb371@math.uni-bielefeld.de>
References: <20170314183804.13788-1-krzk@kernel.org>
 <e1800491-0b60-74d1-1377-756d5b0bb371@math.uni-bielefeld.de>
Message-ID: <20170314190859.y55wlc4z7xdsbbxg@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 08:01:41PM +0100, Tobias Jakobi wrote:
> Hello Krzysztof,
> 
> I was wondering about the benefit of this. From a quick look these are
> all messages that end up in the kernel log / dmesg.
> 
> IIRC %pK does nothing there, since dmest_restrict is supposed to be used
> to deny an unpriviliged user the access to the kernel log.
> 
> Or am I missing something here?

These are regular printks so depending on kernel options (e.g. dynamic
debug, drm.debug) these might be printed also in the console. Of course
we could argue then if access to one of the consoles is worth
securing.

Actually, I think that we should get rid of printing of these kernel
pointers entirely...


Best regards,
Krzysztof

From: matt.fleming@intel.com (Matt Fleming)
Date: Fri, 7 Nov 2014 10:48:33 +0000
Subject: [GIT PULL] arm64: UEFI updates for 3.19
In-Reply-To: <CAKv+Gu9Hf2ATGxVbukxyqihChvc9TDvkejPq6KGkvFdJBPT5LA@mail.gmail.com>
References: <CAKv+Gu8LEFvdu99vCHbHGPmGLpHWdT+Wb2DECzBEEg8g_yynvg@mail.gmail.com>
 <CAKv+Gu8bpgGWRbgdGYHSy515LOXapCm4stv5xJo_tNNhahcTYw@mail.gmail.com>
 <20141107100434.GA32336@arm.com>
 <CAKv+Gu9Hf2ATGxVbukxyqihChvc9TDvkejPq6KGkvFdJBPT5LA@mail.gmail.com>
Message-ID: <1415357313.14686.115.camel@mfleming-mobl1.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-11-07 at 11:29 +0100, Ard Biesheuvel wrote:
> 
> I have confirmation from Matt and another Intel engineer that adding a
> (arguably redundant) 'u32' cast solves the issue.

I think we need to get a better handle on this.

It is completely surprising to me that type promotion from u32 to u64
goes through sign extension.

And by "surprising" I mean, it sounds wrong.

Ard, if you could throw me a unified diff of objdump -dr vmlinux, with
and without the u32 cast, I'll take a look at figuring out what's
happening.

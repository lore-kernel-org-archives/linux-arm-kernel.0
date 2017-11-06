From: samitolvanen@google.com (Sami Tolvanen)
Date: Mon, 6 Nov 2017 08:56:40 -0800
Subject: [PATCH 08/15] arm64: don't pass -maarch64linux to GNU gold
In-Reply-To: <20171103204157.o3y7gapsvulb7kmt@yury-thinkpad>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-10-samitolvanen@google.com>
 <20171103204157.o3y7gapsvulb7kmt@yury-thinkpad>
Message-ID: <20171106165640.GA1993@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 11:41:57PM +0300, Yury Norov wrote:
> Also, IIUC, this patch is not related to LTO, because if ld.gold doesn't
> recognize -maarch64linux with LTO, it will not recognize it in non-LTO
> build. Am I right?

That's correct. ld.gold --help says -m is obsolete, but at the same time,
it supports a number of emulations, just with different names than ld.bfd.
I'll take a closer look at this and see if there's a different flag we
should be passing here instead. Looks like I also have some 0-day issues
to address for v2.

Sami

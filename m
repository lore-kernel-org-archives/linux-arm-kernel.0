From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 28 May 2013 07:55:32 -0700
Subject: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
In-Reply-To: <20130528081910.GA29557@gmail.com>
References: <519DCBEF.3090208@asianux.com>
 <20130523090534.GJ18614@n2100.arm.linux.org.uk>
 <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
 <201305231139.38233.arnd@arndb.de>
 <20130523100409.GK18614@n2100.arm.linux.org.uk>
 <20130528081910.GA29557@gmail.com>
Message-ID: <51A4C564.4040301@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2013 01:19 AM, Ingo Molnar wrote:
> 
> So I think the same principle applies to it as to any other debugging 
> code: it's fine to be able to turn debugging off. It's a performance 
> versus kernel robustness/determinism trade-off.
> 

I suspect, rather, that BUG() should turn into a trap (or jump to a
death routine) under any circumstances.  The one thing that can be
omitted for small configurations are the annotations, which only serve
to output a more human-readable error message.

	-hpa

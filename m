From: geoff@infradead.org (Geoff Levand)
Date: Mon, 30 Mar 2015 09:40:46 -0700
Subject: arm64 kexec hang
In-Reply-To: <55196AEB.2040204@redhat.com>
References: <1427477015.27739.30.camel@infradead.org>
 <5515C799.8010600@redhat.com> <551940F5.9050102@redhat.com>
 <55195FE3.5090409@redhat.com> <55196AEB.2040204@redhat.com>
Message-ID: <1427733646.8283.1.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On Mon, 2015-03-30 at 20:55 +0530, Pratyush Anand wrote:
> So, this was it. With above changes kexec reboot works fine with 
> purgatory too.

OK, great, thanks for working through it.

> By the way, how much execution time expected for verify_sha256_digest? I 
> have not quantified, but it seems that it takes minutes to execute that.

The digest takes a long time, but it doesn't take minutes on
the fast models.  Maybe you could put some print statements
in the code to see if it is the digest that takes the time,
or something else.  It could be a driver or something waiting
for an event, etc.

-Geoff

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Sep 2013 17:06:40 +0100
Subject: [PATCH v3 1/2] video: ARM CLCD: Add DT support
In-Reply-To: <52406646.709@wwwdotorg.org>
References: <1379351934-25415-1-git-send-email-pawel.moll@arm.com>
 <52376180.1090001@wwwdotorg.org> <1379435799.9205.16.camel@hornet>
 <5238CBE9.2060800@wwwdotorg.org> <1379522363.9244.12.camel@hornet>
 <52406646.709@wwwdotorg.org>
Message-ID: <20130923160640.GT12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 10:03:18AM -0600, Stephen Warren wrote:
> It sounds like you could just put LCDControl & 0x2e in the DT rather
> than using values such as 0x100..0x107, which don't appear to match the
> register format you mentioned above.

No.  Platforms which route the outputs to something like VGA or HDMI can
change the framebuffer format.  Your suggestions is far too restrictive.

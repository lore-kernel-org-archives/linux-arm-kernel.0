From: bp@alien8.de (Borislav Petkov)
Date: Tue, 20 Oct 2015 19:36:39 +0200
Subject: [PATCH] EDAC: Add AMD Seattle SoC EDAC
In-Reply-To: <20151020172654.GC4943@leverpostej>
References: <1445282597-18999-1-git-send-email-brijeshkumar.singh@amd.com>
 <20151019205236.GB453@leverpostej> <56266F7E.6030404@amd.com>
 <20151020165744.GE31130@pd.tnic>
 <20151020172654.GC4943@leverpostej>
Message-ID: <20151020173639.GH31130@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 06:26:55PM +0100, Mark Rutland wrote:
> > Btw, how much of this is implementing generic A57 functionality?
> 
> The driver is entirely A57 generic.
> 
> > If a lot, can we make this a generic a57_edac driver so that multiple
> > vendors can use it?
> 
> Yes.

Ok, cool.

> > How fast and how ugly can something like that become?
> 
> Not sure I follow.

In the sense that some vendor might require just a little bit different
handling or maybe wants to read some vendor-specific registers in
addition to the architectural ones.

Then we'll start adding vendor-specific hacks to that generic driver.
And therefore the question how fast and how ugly such hacks would
become.

I guess we'll worry about that when we get there...

So Brijesh, if you only need generic, architectural functionality,
please call it arm64_edac or so and let's add it so that other arm64
vendors can use it too.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

From: bp@alien8.de (Borislav Petkov)
Date: Tue, 20 Oct 2015 18:57:44 +0200
Subject: [PATCH] EDAC: Add AMD Seattle SoC EDAC
In-Reply-To: <56266F7E.6030404@amd.com>
References: <1445282597-18999-1-git-send-email-brijeshkumar.singh@amd.com>
 <20151019205236.GB453@leverpostej> <56266F7E.6030404@amd.com>
Message-ID: <20151020165744.GE31130@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 11:44:46AM -0500, Brijesh Singh wrote:
> > This second property doesn't describe the hardware in any way. It should
> > be runtime-configurable and dpesn't belong in the DT.
> > 
> > Regardless, the binding is wrong. This is in no way specific to AMD
> > Seattle, and per the code is actually used to imply the presence of a
> > Cortex-A57 feature. No reference to AMD Seattle belongs in the DT
> > binding (with the exception of the example, perhaps), nor in the driver.
> > 
> > NAK while this pretends to be something that it isn't. At minimum, you
> > need to correctly describe the feature you are trying to add support
> > for.
> > 
> I will remove AMD specific string in compatibility field and make the poll-delay-msec optional. Will also expose this as module parameter as you suggested below.

Btw, how much of this is implementing generic A57 functionality?

If a lot, can we make this a generic a57_edac driver so that multiple
vendors can use it?

How fast and how ugly can something like that become?

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

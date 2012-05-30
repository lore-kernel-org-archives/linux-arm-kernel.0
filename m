From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 30 May 2012 14:35:46 +0800
Subject: [PATCH v4 6/6] pinctrl: add pinctrl gpio binding support
In-Reply-To: <4FBFBB74.901@wwwdotorg.org>
References: <1337952980-14621-1-git-send-email-b29396@freescale.com>
 <1337952980-14621-6-git-send-email-b29396@freescale.com>
 <4FBFBB74.901@wwwdotorg.org>
Message-ID: <20120530063547.01BD83E065C@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 May 2012 11:03:48 -0600, Stephen Warren <swarren@wwwdotorg.org> wrote:
> I believe Grant wants to change the of_xlate prototype in order to be
> able to return a different gc value, so this will probably need slight
> rework work with that change, once they're both approved. Still, I think
> this is fine for now.

I took a different approach.  Now multiple gpio_chips can use the same
of node, and of_xlate needs to match on the entire gpio specifier, not
just the node.  This code is now in mainline.

g.

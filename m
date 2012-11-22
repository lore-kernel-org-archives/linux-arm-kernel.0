From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 22 Nov 2012 22:40:21 +0100
Subject: [PATCHv9 1/3] Runtime Interpreted Power Sequences
In-Reply-To: <20121122133941.24B883E129E@localhost>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <1353149747-31871-2-git-send-email-acourbot@nvidia.com>
 <20121120215429.B621F3E1821@localhost>
 <13540495.epaCf4JVn9@percival>
 <20121122133941.24B883E129E@localhost>
Message-ID: <20121122214021.GA14771@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 01:39:41PM +0000, Grant Likely wrote:
[...]
> I do think that each sequence should be contained within a single
> property, but I'm open to other suggestions.

IIRC a very early prototype did implement something like that. However
because of the resource issues this had to be string based, so that the
sequences looked somewhat like (Alex, correct me if I'm wrong):

	power-on = <"REGULATOR", "power", 1, "GPIO", "enable", 1>;

Instead we could possibly have something like:

	power-on = <0 &reg 1,
		    1 &gpio 42 0 1>;

Where the first cell in each entry defines the type (0 = regulator, 1 =
GPIO) and the rest would be a regular OF specifier for the given type of
resource along with some defined parameter such as enable/disable,
voltage, delay in ms, ... I don't know if that sounds any better. It
looks sort of cryptic but it is more "in the spirit of" DT, right Grant?

Writing this down, it seems to me like even that proposal was already
discussed at some point. Again, Alex may remember better.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/a95c92c7/attachment.sig>

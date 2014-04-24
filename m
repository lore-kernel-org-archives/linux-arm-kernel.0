From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 24 Apr 2014 16:12:20 +0300
Subject: [PATCHv3 19/41] OMAPDSS: panel-dpi: Add DT support
In-Reply-To: <3615191.vG5AEQORWJ@avalon>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <20140418155107.GB5354@atomide.com> <5358DEEA.1000506@ti.com>
 <3615191.vG5AEQORWJ@avalon>
Message-ID: <53590DB4.8080609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/14 15:44, Laurent Pinchart wrote:

>> I attached prototype patches (based on -rc2) for panel dpi using that
>> approach. It's a bit messier than I'd like, because for non-DT boot we
>> need to request the gpio using the old API, and then convert it to
>> gpio_desc. We can remove that code when all the boards use DT.
> 
> Just FYI, you can use the gpiod API with non-DT platforms if you register GPIO 
> lookup entries in board code with gpiod_add_lookup_table().

Right, but as the board files are going away, I'd rather not touch them
at all if possible.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140424/d09b0579/attachment-0001.sig>

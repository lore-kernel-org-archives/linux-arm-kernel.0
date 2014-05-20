From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 20 May 2014 08:21:19 +0300
Subject: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
In-Reply-To: <20140520045748.GA28812@earth.universe>
References: <537487AE.3060906@ti.com> <20140515182133.GC23659@atomide.com>
 <5375A8A8.7080306@ti.com> <20140516160717.GD22031@atomide.com>
 <20140516174158.GA11733@earth.universe> <20140516180154.GG22031@atomide.com>
 <20140516213907.GL12881@atomide.com> <5379D35F.8040207@ti.com>
 <20140519155732.GA4849@atomide.com> <537A540E.8070302@ti.com>
 <20140520045748.GA28812@earth.universe>
Message-ID: <537AE64F.4020907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/14 07:57, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, May 19, 2014 at 09:57:18PM +0300, Tomi Valkeinen wrote:
>>> 3. Having to maintain a database in kernel of display mappings separately
>>>    in addition to the .dts files.
>>
>> Yes, that's slightly annoying. Not really a big burden, though, as it's
>> quite rare to get a new encoder or panel driver.
> 
> I wonder if the "omapdss," prefix could be added to *all* remote
> endpoints seen by omapdss. Pseudocode:
> 
> for each port in dss {
>     for each endpoint in port {
>         panel = get_phandle(endpoint, "remote-endpoint");
> 
>         /* only add prefix if it's not already there (kexec) */
>         if (panel.compatible != "omapdss,.*")
>             panel.compatible = "omapdss," + panel.compatible;
>     }
> }

Hmm, yes, I think that would work. It would remove the need for the
database, but the code would be slightly more complex as we'd need to
travel through the graph, not just the nodes that are directly connected
to omapdss. I need to try this approach also.

 Tomi

Ps. Sorry for misspelling your name, twice. If I recall right, I even
checked if your name is written with an 'a' or an 'e', but somehow still
managed to get it wrong.


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/5e2e12b2/attachment-0001.sig>

From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Fri, 8 Mar 2013 00:12:41 +0530
Subject: Question about fixed-clock
In-Reply-To: <20130219033931.GA2479@afzal-ThinkPad-R50e>
 <51234B8E.2000504@gmail.com>
Message-ID: <20130307184240.GA3327@afzal-ThinkPad-R50e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Tue, Feb 19, 2013 at 09:09:31AM +0530, Afzal Mohammed wrote:

> Hope invoking of_clk_init before clock generator driver helps

Mails coming from this id are in my personal capacity.

On Tue, Feb 19, 2013 at 10:53:18AM +0100, Daniel Mack wrote:
> On 19.02.2013 02:33, Fabio Estevam wrote:

> > Have you registered it with clk_register_fixed_rate() ?

> Hmm no, I didn't do anything else than adding it to the DT in the first
> place, hoping that a driver will pick it up and add the clock for me.
> But it turns out that of_clk_init() is not called at all on my platform.
> 
> I'm doing this now from omap_generic_init() and it works. If that's an
> appropriate place to call it, I can provide a patch.

Initially didn't realize that it was for an am335x based one.

I feel that for a platform having it's clock tree in DT, of_clk_init
would take care of it, but if clock tree data is not in DT, clock
tree would have to be extended in a non-DT way.

Regards
Afzal

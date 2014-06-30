From: rabin@rab.in (Rabin Vincent)
Date: Mon, 30 Jun 2014 21:43:46 +0200
Subject: [RFC 3/5] clk: use struct clk only for external API
In-Reply-To: <53ADF239.9050008@wwwdotorg.org>
References: <1403855872-14749-1-git-send-email-tomeu.vizoso@collabora.com>
 <1403855872-14749-4-git-send-email-tomeu.vizoso@collabora.com>
 <53ADF239.9050008@wwwdotorg.org>
Message-ID: <20140630194311.GA5167@dator>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 04:37:45PM -0600, Stephen Warren wrote:
> On 06/27/2014 01:57 AM, Tomeu Vizoso wrote:
> > +struct clk {
> > +	struct clk_core clk;
> > +};
> 
> I'm confused why that field isn't a pointer instead.

It becomes a pointer in the following patch.

It's been a while since I created these patches, but IIRC I split it
this way because this patch was large and touching several drivers and
thus I wanted to make it do just the rename and keep core changes to a
minimum.  Such as step may not be needed with Tomeu's series since it's
organized differently.

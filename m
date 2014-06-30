From: rabin@rab.in (Rabin Vincent)
Date: Mon, 30 Jun 2014 21:49:49 +0200
Subject: [RFC 4/5] clk: per-user clock accounting for debug
In-Reply-To: <53ADF3C8.2060702@wwwdotorg.org>
References: <1403855872-14749-1-git-send-email-tomeu.vizoso@collabora.com>
 <1403855872-14749-5-git-send-email-tomeu.vizoso@collabora.com>
 <53ADF3C8.2060702@wwwdotorg.org>
Message-ID: <20140630194949.GB5167@dator>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 04:44:24PM -0600, Stephen Warren wrote:
> On 06/27/2014 01:57 AM, Tomeu Vizoso wrote:
> >  struct clk {
> > -	struct clk_core clk;
> > +	struct clk_core	*core;
> > +	unsigned int	enable_count;
> > +	const char	*dev_id;
> > +	const char	*con_id;
> 
> Why not just store the "struct device *" there instead of pulling the
> name out of it, so ...

Probably because not all of the [of_]clk_get[_sys]() variants supply a
struct device *.

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 4 Mar 2015 10:32:15 +0100
Subject: [PATCH v2 5/5] clocksource: sun5i: Add clock notifiers
In-Reply-To: <54F59829.2070205@linaro.org>
References: <1422265856-27631-1-git-send-email-maxime.ripard@free-electrons.com>
 <1422265856-27631-6-git-send-email-maxime.ripard@free-electrons.com>
 <54C62368.7050600@linaro.org> <20150126143541.GG31568@lukather>
 <20150303085204.GA4911@lukather> <54F59829.2070205@linaro.org>
Message-ID: <20150304093215.GI4911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 12:16:57PM +0100, Daniel Lezcano wrote:
> On 03/03/2015 09:52 AM, Maxime Ripard wrote:
> >On Mon, Jan 26, 2015 at 03:35:41PM +0100, Maxime Ripard wrote:
> >>>>+static int sun5i_rate_cb_clksrc(struct notifier_block *nb,
> >>>>+				unsigned long event, void *data)
> >>>>+{
> >>>>+	struct clk_notifier_data *ndata = data;
> >>>>+	struct sun5i_timer *timer = to_sun5i_timer(nb);
> >>>>+	struct sun5i_timer_clksrc *cs = container_of(timer,
> >>>>+						     struct sun5i_timer_clksrc, timer);
> >>>>+
> >>>>+	switch (event) {
> >>>>+	case PRE_RATE_CHANGE:
> >>>>+		clocksource_unregister(&cs->clksrc);
> >>>>+		break;
> >>>>+
> >>>>+	case POST_RATE_CHANGE:
> >>>>+		clocksource_register_hz(&cs->clksrc, ndata->new_rate);
> >>>>+		break;
> >>>
> >>>Why clocksource_unregister couldn't be in the POST_RATE_CHANGE ?
> >>
> >>Wouldn't that leave a (small, I agree) window where the timer would
> >>run at a rate different to the one it has been registered with?
> >
> >Ping?
> 
> Hi Maxime,
> 
> except I missed something, there were a couple of comments and I was waiting
> a V3.

Indeed, but one of these comments (the one above) was still under
discussion.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150304/5fe478a3/attachment.sig>

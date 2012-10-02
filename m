From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 2 Oct 2012 21:59:14 +0200
Subject: [PATCH v6 3/5] watchdog: at91sam9_wdt: add device tree support
In-Reply-To: <CAHkwnC83DcKXZOtLse_xnYe7zOZ5qwGJVimLkBzDwSJ7Y5vL_Q@mail.gmail.com>
References: <1349094281-28889-1-git-send-email-fabio.porcedda@gmail.com>
 <1349094281-28889-4-git-send-email-fabio.porcedda@gmail.com>
 <20121001124546.GE11837@lunn.ch>
 <CAHkwnC_u+bMX7REU5G3u=cm3VGmOUn+AShruw+ERkPJWtZpxUg@mail.gmail.com>
 <CAHkwnC_5wRgf-DGnUfzkrreT_E1v8i=G8U0qo_5t1DY6+L7c+w@mail.gmail.com>
 <20121001130658.GG11837@lunn.ch>
 <CAHkwnC83DcKXZOtLse_xnYe7zOZ5qwGJVimLkBzDwSJ7Y5vL_Q@mail.gmail.com>
Message-ID: <20121002195914.GG21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I was thinking to add a more generic helper function like this:
> 
> static inline void watchdog_get_dttimeout(struct device_node *node,
> u32 *timeout)
> {
> 	if (node)
> 		of_property_read_u32(node, "timeout", &wdd->timeout);
> }

You forgot to change the function signature. 

Also, if you are adding a generic function, it should be a generic
function for the framework. All drivers should be slowly moving
towards the framework, so adding functions which help you not move
towards the framework are wrong.

	Andrew

From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 06 Aug 2013 12:24:50 +0100
Subject: [PATCH] MFD: Make VEXPRESS MFD controller depends on VEXPRESS
 systems
In-Reply-To: <CAJFYCKEhekp3VnL4XHF2JeMi4VbDJDdxYvVYPeQ0RzJ4oTrgDQ@mail.gmail.com>
References: <1375603249-27206-1-git-send-email-manjunath.goudar@linaro.org>
 <1375785375.12043.4.camel@hornet>
 <CAJFYCKEhekp3VnL4XHF2JeMi4VbDJDdxYvVYPeQ0RzJ4oTrgDQ@mail.gmail.com>
Message-ID: <1375788290.12043.38.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-08-06 at 12:18 +0100, Manjunath Goudar wrote:

> You are suggesting me to fix this issue using following code.
> 
> 
> #ifdef CONFIG_OF
>                         bridge_node = of_find_node_by_phandle(
>                                         be32_to_cpup(prop));
> #endif
>                 break;
>                 }
> #ifdef CONFIG_OF
>                 bridge_node = of_get_next_parent(bridge_node);
> #endif
> 
Em, this would be a possibility, but I think the right thing to do is to
add dummies to "include/linux/of.h". Search for "of_get_parent" and
"of_find_node_by_name" in this header - you will find declarations in
"#ifdef CONFIG_OF" block and dummy implementations (returning NULL) in
the equivalent #else part.

Pawe?

From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 28 May 2013 09:06:48 -0700
Subject: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
In-Reply-To: <201305281743.52649.arnd@arndb.de>
References: <519DCBEF.3090208@asianux.com> <20130528081910.GA29557@gmail.com>
 <51A4C564.4040301@zytor.com> <201305281743.52649.arnd@arndb.de>
Message-ID: <51A4D618.3080208@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2013 08:43 AM, Arnd Bergmann wrote:
> 
> Right, that is what the patch I just posted does.
> 
> On a related note, I found that WARN_ON() can no longer be compiled
> out since there is already code that relies on the side-effects of
> the condition. I assume that was an intentional change I missed,
> since it used to be defined so that you could remove it completely.
> 

It is possible to define WARN_ON() as:

#define WARN_ON(x) ((void)(x))

... which preserves side effects.

	-hpa

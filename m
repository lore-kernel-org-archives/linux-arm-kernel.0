From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 22 Oct 2012 08:59:17 +0200
Subject: [PATCH 1/5] net/cadence: get rid of HAVE_NET_MACB
In-Reply-To: <20121021.192707.1747557282711878897.davem@davemloft.net>
References: <1350829392-3812-1-git-send-email-manabian@gmail.com>
 <1350829392-3812-2-git-send-email-manabian@gmail.com>
 <20121021.192707.1747557282711878897.davem@davemloft.net>
Message-ID: <CAGhQ9VyPNDKWwGCZ2Mghm7dOcyTqTgL=ahv+1EQaXtz-Hd7OMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 1:27 AM, David Miller <davem@davemloft.net> wrote:
>
> You do know that this is going to generate warnings on 64-bit
> platforms?
>
> I was hoping you would have noticed and corrected this before
> enabling the driver everywhere, I guess my expectations were
> way too high :-/

ah, sorry.

Yes, macb seem to generate some integer overflows on ~0UL on 64-bit. I
have a patch that turns ~0UL into -1.

I can repost the series with fix included. Do you want me to do that?

regards
Joachim Eastwood

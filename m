From: prasannatsmkumar@gmail.com (PrasannaKumar Muralidharan)
Date: Thu, 15 Dec 2016 00:47:16 +0530
Subject: [PATCH v2] crypto: sun4i-ss: support the Security System PRNG
In-Reply-To: <20161214050551.GD9592@gondor.apana.org.au>
References: <1480934922-20732-1-git-send-email-clabbe.montjoie@gmail.com>
 <20161205123705.GA10732@gondor.apana.org.au> <20161205125738.GA13525@Red>
 <20161207120900.GC20680@gondor.apana.org.au> <20161207125127.GB28218@Red>
 <20161208090618.GB22932@gondor.apana.org.au> <20161213141059.GB10647@Red>
 <20161214050551.GD9592@gondor.apana.org.au>
Message-ID: <CANc+2y7C-=S_5MZuqP0Q+y2FwHqS2_p9-iYuAu1A1tXqzxp_oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> I have found two solutions:
>
> No we already have algif_rng so let's not confuse things even
> further by making hwrng take PRNGs.

Even if both the solutions could not be adopted I think there must be
a way for applications to use similar API to get true rng or prng.
Given the case that no user complained about prng data when using
/dev/hwrng is it safe to assume that the random data generated is
acceptable for users? If so, the drivers can be left without any
modification.

Should there be a mandate that driver will be accepted only when it
passes 'rngtest'. This will make sure that prng drivers won't get
added in future.

Regards,
PrasannaKumar

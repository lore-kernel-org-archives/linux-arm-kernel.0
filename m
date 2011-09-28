From: sebastian.rasmussen@stericsson.com (Sebastian RASMUSSEN)
Date: Wed, 28 Sep 2011 11:18:04 +0200
Subject: [PATCH 3/3] mmc: mmci: Change vdd_handler to a generic ios_handler
In-Reply-To: <CACRpkdZpbs06Gi27dpVearp1zV6Xi-8-88E1GJmRca3u_N1zbg@mail.gmail.com>
References: <1317123753-29902-1-git-send-email-ulf.hansson@stericsson.com>
	<CACRpkdZpbs06Gi27dpVearp1zV6Xi-8-88E1GJmRca3u_N1zbg@mail.gmail.com>
Message-ID: <ECD438FDEF6BD742895E554C24725A401C4F1AE111@EXDCVYMBSTM005.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'm guessing it was some feature intended to control e.g. a
> regulator of some kind by routing them off-chip (since mixed-signal
> chips rarely have MMC controllers inside...) and most designers
> already have their own regulator designs so it made no sense
> for anyone to actually implement it that way.

Yup, I think ARM PL180 HW IP developers envisioned that the SD-card
regulator and/or level-shifter would utilize these signals electrically
to configure what voltage to use. As far as I read the old TRM the way 
these bits encoded voltage levels were application-specific so I can't
see that there would be any consensus of how to interpret them either.

> If some vendor would actually start using these bits for the
> intended purpose I guess we could adapt. (The pirate driver
> msm_sdcc.c does not seem to use these bits either BTW.)

I never did check whether msm_sdcc used those, but it seemed
unimportant at the time since it's not the same driver (yet).
Nice to know that neither driver uses those though.

 / Sebastian

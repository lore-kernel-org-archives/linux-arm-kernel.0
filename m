From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 17 May 2016 08:54:27 +0200
Subject: [PATCH 02/16] clk: sunxi-ng: Add common infrastructure
In-Reply-To: <20160516201509.GL27618@lukather>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-3-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v67XWt6tjG_xXWgGatTaiN5uYQb2_Q6bgixMDUkHfVHLHg@mail.gmail.com>
 <20160515183122.GA27618@lukather>
 <20160516100239.a93a238b0d458b38a3689a95@free.fr>
 <20160516201509.GL27618@lukather>
Message-ID: <20160517085427.f2f3aa0c66686f8f5f6318ff@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 May 2016 22:15:09 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > > Yes, I intended it to be a simple busy waiting loop since I don't
> > > expect it to be very long. Do yu have any more data on how much time
> > > it usually takes?
> > 
> > I have a Soc in which the rate of the audio clock is stable after a
> > good second.
> 
> You mean before the clock is actually stable, or before the lock bit
> is cleared?
> 
> Which SoC is it? As far as I've seen, only the H3 allows to configure
> the stable time, and while by default it will take 16us, you can
> configure as high as 66ms (which is still way higher than the current
> limit).

Hi Maxime,

Well, it is not a SoC, but an external chip, the SI5351 (in the Dove
Cubox). There is no lock bit, but as it is used for audio, and as I did
not set any delay at streaming start time, I can hear when the clock is
stable.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/

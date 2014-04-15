From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 15 Apr 2014 17:57:39 +0800
Subject: [PATCH 5/5] spi: sirf: fix spi full-duplex DMA transferring issue
In-Reply-To: <20140415092609.GJ12304@sirena.org.uk>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
 <1397457001-5266-6-git-send-email-21cnbao@gmail.com>
 <20140414200628.GX25182@sirena.org.uk>
 <CAGsJ_4yO-LGJEkpNy=dizQWjSE3pHEBOrrPndho3jt1_YMRvHg@mail.gmail.com>
 <20140415092609.GJ12304@sirena.org.uk>
Message-ID: <CAGsJ_4yWkBr2x=hLNaCsVwytDTua48kR+DEO86A6vH5x+jLEDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-15 17:26 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Tue, Apr 15, 2014 at 09:43:24AM +0800, Barry Song wrote:
>
>> i felt strange too at the first look from internal gerrit. qipan told
>> me there is one:
>> drivers/spi/spidev.c
>
> OK, that needs fixing.  That code predates anyone doing DMA.

if it is out of specification, it seems fixing spidev.c is not enough
as spi transfer actually needs an precondition of tx!=rx now.

-barry

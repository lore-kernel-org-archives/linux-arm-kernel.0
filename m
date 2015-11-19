From: julian.calaby@gmail.com (Julian Calaby)
Date: Fri, 20 Nov 2015 09:59:11 +1100
Subject: [linux-sunxi] [PATCH] spi: dts: sun4i: Add support for inter-word
 wait cycles using the SPI Wait Clock Register
In-Reply-To: <1447948422-4915-2-git-send-email-mweseloh42@gmail.com>
References: <1447948422-4915-1-git-send-email-mweseloh42@gmail.com>
 <1447948422-4915-2-git-send-email-mweseloh42@gmail.com>
Message-ID: <CAGRGNgWQLE5h03+4shLmqD6iW_p=L-i3ewdLb8ndWpxGHWh4rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcus,

On Fri, Nov 20, 2015 at 2:53 AM, Marcus Weseloh <mweseloh42@gmail.com> wrote:
> Adds support and documentation for a new slave device property
> "sun4i,spi-wdelay" that allows to set the SPI Wait Clock Register per
> device / transfer. The SPI hardware will wait the specified amount of
> SPI clock periods (plus a constant 3 clock periods) before transmitting
> the next word.

Should you possibly hide the 3 clock periods from the user?

I.e. they set whatever they want for the wdelay, we set it to the
closest number we can that's greater or equal to what they ask for.

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

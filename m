From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 20 May 2010 15:11:56 +0200
Subject: Support Question
In-Reply-To: <AANLkTin9qYxhbKe_ZDFvPbteM6Zn1H2M5jY6mAaH_Jxu@mail.gmail.com>
References: <1274199223.1763.0.camel@ubuntu.ubuntu-domain>
	<AANLkTin9qYxhbKe_ZDFvPbteM6Zn1H2M5jY6mAaH_Jxu@mail.gmail.com>
Message-ID: <4BF5351C.80306@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/05/2010 19:06, Amit kumar :
> Dear Experts,
> 
> I am using SBC 9260 for development of a data acquisition platform. I am
> using the SPI for data acquisition through 14 bit ADC slave. Currently
> my board has debian 5.0 kernel version 2.6.30. I am using the spidriver
> (spidev )for using the SPI on the board in master mode . Everything is
> working fine and I am able to send and receive data . The only problem
> is between the activation and deactivation of chip select.It takes
> around 70microseconds for chipselect deactivation and then activation .
> Since speed of my 4 channel ADC is 1MSPS so i need to bring down delay
> as minimum as possible. I checked out the value of the registers
> DLYBCS , DLYBCT , DLYBS and all are indicating the values 0.
> 
> Therefore I don;t have any idea from where the delay is being
> introduced. Is it a problem of OS or there is nythng else involved .
> Kindly guide me through this . I need urgent help .... any information
> abt delay is welcome.

In the atmel SPI driver, chipselect are managed by GPIO and not
automatically by the IP. I think that this is why you experience such
delays.
I am not totally aware about the reasons for this hand-made management
but I guess that you can find information on this mailing-list...

Best regards,
-- 
Nicolas Ferre

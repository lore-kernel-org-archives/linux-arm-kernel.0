From: J.Weitzel@phytec.de (Jan Weitzel)
Date: Mon, 18 Apr 2011 11:50:32 +0200
Subject: The cleanest way to power off a board inside the kernel.
In-Reply-To: <BANLkTinwsEmyCRVbRBm+grhth9Dx8N+Bfg@mail.gmail.com>
References: <BANLkTinwsEmyCRVbRBm+grhth9Dx8N+Bfg@mail.gmail.com>
Message-ID: <1303120232.23368.3.camel@lws-weitzel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 18.04.2011, 11:23 +0200 schrieb javier Martin:
> There are some boards out there, including Beagleboard xM, which are
> provided with a PMIC that is able to enable or disable power supply
> for the system. The interfaces used for that purpose usually include
> gpios or I2C.
> What is the cleanest way, provided there are some, to tell those
> circuits at the end of the power down process to cut off the power
> supply of the system?
> 
> At first glance I thought there could be a board specific hook for
> that purpose but I couldn't find any, just an endless loop "while
> (1);" instead.
Look for pm_power_off. It's a function pointer to optional machine
specific functions
.
Regards, Jan

From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 04 Sep 2017 12:04:58 +0200
Subject: [PATCH v3 0/8] PM / ACPI / i2c: Deploy runtime PM centric path
 for system sleep
In-Reply-To: <20170904054637.GA23707@wunner.de>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
 <1668277.7DWLdgHGid@aspire.rjw.lan> <20170904054637.GA23707@wunner.de>
Message-ID: <3410095.RTqPGnhnfq@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 4, 2017 7:46:37 AM CEST Lukas Wunner wrote:
> On Mon, Sep 04, 2017 at 02:17:21AM +0200, Rafael J. Wysocki wrote:
> > OTOH I'm starting to think that direct_complete is only theoretically
> > useful and may not be actually set very often in practice, whereas it
> > adds significant complexity to the code, so I'm not sure about it any
> > more.
> 
> That makes me come out of the woodwork as a direct_complete fan:
> 
> Runtime resuming a discrete GPU on a modern dual GPU laptop takes about
> 1.5 sec, runtime resuming Thunderbolt controllers more than 2 sec.
> A discrete GPU easily consumes 10W, a Thunderbolt controller 2W.
> 
> So not having direct_complete would noticeably delay system suspend and
> resume as well as reduce battery life.

Well, that's a good reason for having it. :-)

Thanks,
Rafael

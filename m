From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 22 May 2013 11:17:36 +0400
Subject: =?UTF-8?B?UmVbM106IFtQQVRDSF0gQVJNOiBpb211eC1teDUxOiBBbHdheXMgZGVmaW5l?=
 =?UTF-8?B?IFBVIEUgZm9yIHBpbnMgdXNlZCBhcyBHUElP?=
In-Reply-To: <20892.28064.82907.942799@ipc1.ka-ro>
References: <1369124845-19244-1-git-send-email-shc_work@mail.ru>
 <1369203552.559574351@f389.i.mail.ru>
 <20892.28064.82907.942799@ipc1.ka-ro>
Message-ID: <1369207056.596630214@f96.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Alexander Shiyan writes:
> > > On Tue, May 21, 2013 at 12:27:25PM +0400, Alexander Shiyan wrote:
> > > > This patch adds a PUE bit for pins which used as GPIO. This allow
> > > > to use the GPIOs correctly as inputs when source is open-drain with
> > > > external pullup resistor (IRQ open-drain outputs for example).
> > > 
> > > I don't understand. If there's an external pullup why do you want to
> > > turn on the internal one?
> > 
> > It is just switch off keeper circuit.
> > 
> If you want to switch the keeper circuit off why don't you do that by
> removing PAD_CTL_PKE rather than adding PAD_CTL_PUE?

Again, I do not know which the solution here is better. If we remove
the PKE bit, for some pins it will be removed the default pullup/pulldown (PUS = 0),
so it may affect the some running configuration.

---

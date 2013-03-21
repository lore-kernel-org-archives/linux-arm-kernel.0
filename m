From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Mar 2013 19:03:52 +0000
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <514B4A79.1070501@gmail.com>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <1363883179-1361-6-git-send-email-gregory.clement@free-electrons.com>
 <514B4A79.1070501@gmail.com>
Message-ID: <201303211903.52383.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 March 2013, Rob Herring wrote:
> >       soc {
> > -             #address-cells = <1>;
> > -             #size-cells = <1>;
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> 
> If all the addresses for the soc bus are below 4GB or even within a 4GB
> range if using the ranges property, then changing all this and
> everything below it is kind of pointless.

Good point. We'll probably also have to change it all again when we add a new
binding for that bus in 3.10, so it makes sense to change it only once.

	Arnd

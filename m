From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 21 Jun 2011 12:27:35 +0100
Subject: [PATCH 2/6] serial: samsung: Add device tree support for
	s5pv210 uart driver
In-Reply-To: <BANLkTi=+FKz-uPtSv572y5ORorMeGR8Anw@mail.gmail.com>
References: <1308567752-13451-1-git-send-email-thomas.abraham@linaro.org>
	<1308567752-13451-3-git-send-email-thomas.abraham@linaro.org>
	<BANLkTi=+FKz-uPtSv572y5ORorMeGR8Anw@mail.gmail.com>
Message-ID: <20110621112734.GA25032@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 10:43:50AM -0600, Grant Likely wrote:

> I think I've commented on this before, but I do try to avoid direct
> coding registers into the DT.  That said, sometimes there really isn't
> a nice human-friendly way of encoding things and direct register
> values is the best approach.

Hrm, that's going to mean a *lot* of code doing parsing, especially if
we also follow through and also have proper parsers for all the
bitfields and don't just push the magic numbers down a level.  In
principal I agree with you that that's what we should be doing but in
practice it seems like an awful lot of effort on all sides.

I'm not against it but if we're going to go down this road I think we
need to put some work into helpers to cut down on the parsing code.  The
obvious one is a helper which maps a table of strings into numbers for
things like selecting multi-function pin functions.

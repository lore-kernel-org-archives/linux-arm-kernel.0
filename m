From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Aug 2013 09:02:53 +0100
Subject: [RFC PATCH] clock: correct the comparison parameter of MHz
In-Reply-To: <1375861660-32525-1-git-send-email-voice.shen@atmel.com>
References: <1375861660-32525-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20130807080253.GE23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 03:47:40PM +0800, Bo Shen wrote:
> correct the comparison parameter of MHz from 4,000,000 to 1,000,000

You're assuming this wasn't intentional.  As the division by 1000000
ends up losing the fractional rate, I decided to leave 1-4MHz as kHz,
so something like 1.832MHz would be displayed as 1832kHz and not
1MHz.

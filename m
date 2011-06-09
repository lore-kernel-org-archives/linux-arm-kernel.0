From: christian.riesch@omicron.at (Christian Riesch)
Date: Thu, 9 Jun 2011 12:05:12 +0200
Subject: [PATCH V2] davinci: da850: move input frequency to board specific
	files
In-Reply-To: <874o42wpec.fsf@ti.com>
References: <1306312622-4901-1-git-send-email-christian.riesch@omicron.at>
	<1306488053-27978-1-git-send-email-christian.riesch@omicron.at>
	<874o42wpec.fsf@ti.com>
Message-ID: <BANLkTinjV3cdNe92MkiWcXH8GJmOcF_nuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Tue, Jun 7, 2011 at 12:44 AM, Kevin Hilman <khilman@ti.com> wrote:
> Christian Riesch <christian.riesch@omicron.at> writes:
>
>> From: Bob Dunlop <bob.dunlop@xyzzy.org.uk>
>>
>> Currently the input frequency of the SoC is hardcoded in the SoC specific
>> da850.c file to 24 MHz. Since the SoC accepts input frequencies in a wide
>> range from 12 to 50 MHz, boards with different oscillator/crystal
>> frequencies may be built.
>>
>> This patch allows setting a different input frequency in the board
>> specific files to support boards with oscillator/crystal frequencies other
>> than 24 MHz.
>>
>> Signed-off-by: Bob Dunlop <bob.dunlop@xyzzy.org.uk>
>> Signed-off-by: Christian Riesch <christian.riesch@omicron.at>
>
> Why not allow board code to just do a clk_set_rate()?

I'm fine with this method (In fact it was the first thing that I
tried, I added a .set_rate method to ref_clk, it worked well for me).
However I wonder whether first initializing the clock with the wrong
value (24 MHz) and later correcting it via clk_set_rate() would break
something. In the meantime, the data in the clock tree do not reflect
the actual frequencies that are present on the SoC.

Christian

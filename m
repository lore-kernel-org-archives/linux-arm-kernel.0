From: ahaslam@baylibre.com (Axel Haslam)
Date: Tue, 25 Oct 2016 14:55:48 +0200
Subject: [PATCH/RFT v2 09/17] regulator: fixed: Add over current event
In-Reply-To: <20161024181937.GP17252@sirena.org.uk>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-10-ahaslam@baylibre.com>
 <20161024175320.GO17252@sirena.org.uk>
 <CAKXjFTNZhWTZSXtLZo8EieBtAPn_J-MM+-g8yCRJiV6UBspB9Q@mail.gmail.com>
 <20161024181937.GP17252@sirena.org.uk>
Message-ID: <CAKXjFTOHcqRFtbXMXSTyUZ3P00eRMz1N3d62Y3NWVZJDGeScZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Oct 24, 2016 at 8:19 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Oct 24, 2016 at 08:11:40PM +0200, Axel Haslam wrote:
>> On Mon, Oct 24, 2016 at 7:53 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> > does it make sense to report this as a mode, we don't report other error
>> > conditions as modes but instead use REGULATOR_STATUS_ with the
>> > get_status() operation?
>
>> I used mode, because when the regulator toggles the overcurrent
>> line, it means that it has entered a current limited mode, at least the
>> regulator im looking at. ill change to STATUS
>
> That's not what regulator modes are - please look at the documentation
> for the defines here.  They're about the quality of regulation.

To be able to use regulator to handle the overcurrent pin, i need to be able
to somehow retrieve the over current pin state from the regulator driver.

As i was trying your suggestion, i remembered why i thought i should use
mode instead of status: Status seems to be for internal regulator driver use,
there is no regulator_get_status, function and REGULATOR_STATUS_* are defined
in driver.h and not in consumer.h as  REGULATOR_MODE_*

it seems that status is only used to print sysfs info.

Would you be ok if i allow consumers to get the status via a new
"regulator_get_status" call?

Regards
Axel.

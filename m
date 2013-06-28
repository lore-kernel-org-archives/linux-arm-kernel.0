From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 28 Jun 2013 08:35:42 -0600
Subject: [PATCH v1 08/12] input: keypad-matrix: tell GPIO pins from matrix
 lines
In-Reply-To: <20130628075240.GU24305@book.gsilab.sittig.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-9-git-send-email-gsi@denx.de>
 <51C4C87B.3050300@wwwdotorg.org>
 <20130622100052.GH24305@book.gsilab.sittig.org>
 <51C8D599.2010706@wwwdotorg.org>
 <20130628075240.GU24305@book.gsilab.sittig.org>
Message-ID: <51CD9F3E.9060003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2013 01:52 AM, Gerhard Sittig wrote:
> 
> [ late reply, just catching up with the backlog ]
> 
> On Mon, Jun 24, 2013 at 17:26 -0600, Stephen Warren wrote:
>>
>> [ ... sparse matrices, not all columns/rows populated ... ]

>> On some Tegra boards, there end up
>> being rather tri-angular keymaps, where key positions (0, 0), (0, 1),
>> (0, 2), (1, 1), (1, 2), (2, 2) end up being used. In this scenario,
>> detailed investigation of the keymap would reveal:
>>
>> * Only scan columns 0..2
>> * For column 0, scan rows 0..2
>> * For column 1, scan rows 1..2
>> * For columm 2, scan row 2.
> 
> That's another question I had.  So far I was concerned with just
> polling or scanning the relevant columns, while all the rows for
> a given column were queried (as the driver always used to do).
> 
> Now you raise the question of whether rows should get queried as
> well depending on whether "a key may sit there".  It wasn't the
> exact question I raised, but I added a comment to the spot where
> input subsystem events get generated:  Is the driver expected to
> emit events for matrix positions where no key map entry exists?

I would assume there is no need to, but I don't know for sure. Perhaps
Dmitry can answer that?

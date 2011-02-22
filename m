From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Feb 2011 19:52:41 +0000
Subject: [PATCH 3/5] ARM: tegra: update GPIO chained IRQ handler to use
	EOI in parent chip
In-Reply-To: <001d01cbd2c5$a97f17a0$fc7d46e0$@deacon@arm.com>
References: <1298302096-21275-1-git-send-email-will.deacon@arm.com>
	<1298302096-21275-4-git-send-email-will.deacon@arm.com>
	<AANLkTimYvHOzv2w_oxOB5HJfMhp8Kg_A0-Y7Mj41M-HX@mail.gmail.com>
	<001d01cbd2c5$a97f17a0$fc7d46e0$@deacon@arm.com>
Message-ID: <20110222195241.GA29559@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 22, 2011 at 07:21:09PM -0000, Will Deacon wrote:
> Hmm, I've seen this problem before. See Russell's explanation here:
> 
> http://lists.arm.linux.org.uk/lurker/message/20101201.172105.938cf2c5.en.html
> 
> I don't believe it's a problem my end, but if it starts happening
> regularly I'll investigate further.

I wonder what's happening here is that the mailing list is converting
your messages from quoted-printable to plain text.

Looking at two of your recent messages, one of them came via the mailing
list.  That one was not quoted-printable.  These ones which you Cc'd me
on, and arrived before the copy from the mailing list came through as
quoted-printable though.

AFAIK, git-send-email doesn't generate quoted-printable mails.  From what
I remember, it doesn't generate any MIME headers at all either, expecting
the first MTA to be able to figure out what to do with the following
string of bytes.  It's not surprising that some MTAs may do weird things
with that.

I don't use git send-email, but instead have my own scripts based around
git format-patch, and adds the following headers:

  MIME-Version: 1.0
  Content-Disposition: inline
  Content-Type: text/plain; charset="us-ascii"

to each file it produces, as well as other header modifications.  I've
then got a separate script which sends the contents of the directory
slowly (20sec between each message) via '/usr/sbin/sendmail' (iow,
the local MTA - exim for me) to make it a little kinder on MTAs.

I did try with utf-8 but istr that caused problems, possibly resulting
in qp-conversion, or maybe resulted in MTAs remarking it as a us-ascii
charset.  As 99.9999999% of stuff I mail out from git is 7bit ASCII...

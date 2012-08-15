From: josh.coombs@gmail.com (Josh Coombs)
Date: Wed, 15 Aug 2012 07:55:42 -0400
Subject: PATCH Add support for the Iomega IX2-200 Device Tree
In-Reply-To: <20120815111209.GB22226@titan.lakedaemon.net>
References: <3CAEA3DD-9D2C-4052-957D-D09E6EB9B64E@gmail.com>
 <20120814235653.GA22226@titan.lakedaemon.net>
 <95D5BE56-A79F-4422-B1CE-7AD010A9D70E@gmail.com>
 <20120815111209.GB22226@titan.lakedaemon.net>
Message-ID: <CAMW5Ufb-8NrWu6vsJ+RezrLEGj-Wfm5Tc+0BK9_2qzn671FrpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Sorry i meant board-dt in the previous message and the name just
>> getting used to the mail program on os x aswel. I have run through the
>> checkpatch.pl script and it tells me there are no errors but i just
>> found out a few minutes ago theres a fix for the 2 sata ports not
>> working (on all kirkwood devices as far as i know) so i am going to
>> test that now as it envolves modifying a line in the dts file.
>
> Ok.  Please let everyone know in the comment portion of the patch (after
> the --- line) that your patch depends on this fix.  I haven't seen the
> patch you're referring to yet.  I'll keep my eye out for it.

What he's referring to is needing to up the coherent_pool size to get
a Kirkwood device with two SATA ports to init completely.  I brought
the topic up on arm-kernel under the subject 'Potential Regression in
3.6-rc1 - Kirkwood SATA' and Aaro Koskinen suggested the root cause
and potential fix of adding coherent_pool=1M to the bootargs.  I
didn't think to cc you in the discussion, sorry about that.  So there
isn't a pending patch yet, just a suggestion of altered bootargs.

Josh Coombs

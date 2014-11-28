From: grant.likely@linaro.org (Grant Likely)
Date: Fri, 28 Nov 2014 15:33:08 +0000
Subject: [PATCH v3 2/3] of: add optional options parameter to
 of_find_node_by_path()
In-Reply-To: <20141128152512.2152EC40884@trevor.secretlab.ca>
References: <1417110967-16284-1-git-send-email-leif.lindholm@linaro.org>
 <1417110967-16284-3-git-send-email-leif.lindholm@linaro.org>
 <20141128004403.08D90C40A7F@trevor.secretlab.ca>
 <20141128113428.GM2361@bivouac.eciton.net>
 <20141128152512.2152EC40884@trevor.secretlab.ca>
Message-ID: <CACxGe6s=PETLBN_Y5Mk6zM677-1SrNUwAJoUK4bHdkPObBH4JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 3:25 PM, Grant Likely <grant.likely@linaro.org> wrote:
> On Fri, 28 Nov 2014 11:34:28 +0000
> , Leif Lindholm <leif.lindholm@linaro.org>
>  wrote:
>> On Fri, Nov 28, 2014 at 12:44:03AM +0000, Grant Likely wrote:
>> > > + separator = strchr(path, ':');
>> > > + if (separator && opts)
>> > > +         *opts = separator + 1;
>> > > +
>> >
>> > What about when there are no opts? Do we require the caller to make sure
>> > opts is NULL before calling the function (which sounds like a good
>> > source of bugs) or do we clear it on successful return?
>> >
>> > I think if opts is passed in, but there are no options, then it should
>> > set *opts = NULL.
>>
>> Yeah, oops.
>>
>> > There should be test cases for this also. Must set opts to NULL on
>> > successful return, and (I think) should leave opts alone on an
>> > unsuccessful search.
>>
>> I would actually argue for always nuking the opts - since that could
>> (theoretically) prevent something working by accident in spite of
>> error conditions.
>>
>> How about the below?
>
> Perfect, applied with one fixup below...

And by the way, let me say well done on this patch. It is elegantly
implemented within the framework already there.

g.

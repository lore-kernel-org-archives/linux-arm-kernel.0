From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Sat, 23 Nov 2013 16:16:18 -0800
Subject: crypto dependency in bit sliced AES
In-Reply-To: <20131123013924.GA16533@gondor.apana.org.au>
References: <CAKv+Gu8PESZ3uFZ6Rf+sma9QeRd7xSyrEa=RVCeDR1KtmLKEAA@mail.gmail.com>
 <20131122225256.GG16735@n2100.arm.linux.org.uk>
 <CA+55aFwRWGdA934GQdo6QpEuxRxeECvrpi9ctJWcVQ5pCyF1iw@mail.gmail.com>
 <20131123013924.GA16533@gondor.apana.org.au>
Message-ID: <CAADWXX9CRRZF3Ewt5sXWQuCdKVVpe_-TdT+BW_MRrMUG2h1eGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both this email *and* your repeated pull request again got marked as spam.

It has nothing to do with the number of recipients (which wasn't that
big anyway).

At a guess, it's something about your "gondor.apana.org.au" address
that makes gmail just hate you. In particular it is likely related to
this:

  Received-SPF: neutral (google.com: 178.18.16.133 is neither
permitted nor denied by best guess record for domain of
herbert at gondor.apana.org.au) client-ip=178.18.16.133;
  Authentication-Results: mx.google.com;
       spf=neutral (google.com: 178.18.16.133 is neither permitted nor
denied by best guess record for domain of herbert at gondor.apana.org.au)
smtp.mail=herbert at gondor.apana.org.au

with that whole "best guess record for domain" crap. So at the very
least your spf records are questionable.

And when I do "nslookup -q=mx gondor.apana.org.au" I get:

  Server: 192.168.0.1
  Address: 192.168.0.1#53

  Non-authoritative answer:
  gondor.apana.org.au canonical name = gondor.hengli.com.au.
  gondor.hengli.com.au mail exchanger = 10 mx2.hengli.com.au.
  gondor.hengli.com.au mail exchanger = 5 mx1.hengli.com.au.

  Authoritative answers can be found from:"

where it's worth noting that the sources of authoritative answers is
an empty list.

So your email setup looks rather questionable. Which is most likely
why gmail spam filters hate you.

I've marked those messages as not being spam, but quite frankly, this
will likely continue to be a problem unless you try to sort out your
mail sending ways. The fact is, spam is a huge problem, and people who
send messages from hosts that don't actively try to validate the email
are going to be part of the problem.

I do not know if it's your own host, or apana.org.au that ends up
being the problem. Please talk to people who actually know about all
the SPF rules etc.

             Linus

On Fri, Nov 22, 2013 at 5:39 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Fri, Nov 22, 2013 at 03:48:24PM -0800, Linus Torvalds wrote:
>>
>> Herbert, any idea why gmail would consider your emails spam? Mind
>> re-sending it once more, and I'll try to see if I get it..
>
> Sure I've just done a resend.
>
>> I actually see an email from Herbert *replying* to Borislav in my
>> archives, but I do not see the pull request emails themselves.
>
> Based on that perhaps it's because I have too many (4) recipients
> in the pull request?
>
> I'll do another resend and move the receipients into the cc field.
>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

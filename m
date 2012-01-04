From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 04 Jan 2012 10:48:31 +0100
Subject: linux-next: interesting merges in the arm-soc tree
In-Reply-To: <20120104104758.26b0ca5268d10fbf7b95903a@canb.auug.org.au>
References: <20120104104758.26b0ca5268d10fbf7b95903a@canb.auug.org.au>
Message-ID: <4F04206F.6070500@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/04/2012 12:47 AM, Stephen Rothwell :
> Hi all,
> 
> I noticed that the arm-soc tree has merged in the v4l-dvb and the 
> slave-dma trees today.   Is there some good reason for this?  It 
> fixes a few conflicts (but that is not excuse) and there may be 
> dependencies in a driver on the v4l-dvb tree (but maybe that means 
> that that driver should be merged via the v4l-dvb tree - it looks 
> like the "at91/drivers" is based on the v4l-dvb tree, so probably 
> doesn't depend on anything else on the arm-soc tree).
> 
> If nothing else, are you sure that neither of those merged trees 
> will rebase?  You have also just inherited any bugs in those two 
> trees.

We discussed this with Guennadi and Olof and decided to include this
dependency in arm-soc. Anrd and Olof said that the at91/drivers branch
could be merged late during the merge window and will make sure that
the corresponding v4l-dvb branch is actually upstream before sending
the pull request.

Here is the conversation about this:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/144547/focus=144743

Best regards,
- -- 
Nicolas Ferre
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPBCBqAAoJEAf03oE53VmQTtgH/2h9WBxjnwgcUrKOykHrXPPT
apB4y7FQA0EIaO6RWPi6LpXuBtEz+tV2mGyaXahUETgKQ9Oc459+FxoSoOmJyssh
vbaA4uWrPhdHXVVo464SLwxr/flUeb09iY3C+nIHn9JlYtqUriYOVUNCa+k/Oszp
AoaeDHPfjkkZ+07vZdjpYu9BC/NidijJvQDWCZ+Z4Jsfi7cygIB+HZGNAptPFmyq
jILk4LIdJcqsKmD0UA3i43WkTdqJQ4reZQk96POAX6151p7Ieh0PXNn68+oCYnwO
c6JAaM1FVsEhZAV1G/w0EpfDa0JNHep8h87GOHernrU6KuOVrWB0SCp5l0zERiw=
=mJTb
-----END PGP SIGNATURE-----

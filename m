From: carmelo.amoroso@st.com (Carmelo AMOROSO)
Date: Tue, 11 Jan 2011 16:56:02 +0100
Subject: [PATCH 1/2] stackprotector: add stack smashing protector
	generic implementation
In-Reply-To: <AANLkTinZCDRVwwchcB85Wock8nBYK1eJrTWPbgJ-roGh@mail.gmail.com>
References: <1293111851-7175-1-git-send-email-filippo.arcidiacono@st.com>
	<4D245D16.5010702@st.com>
	<AANLkTinZCDRVwwchcB85Wock8nBYK1eJrTWPbgJ-roGh@mail.gmail.com>
Message-ID: <4D2C7D92.1090104@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/11/2011 6:30 AM, Mike Frysinger wrote:
> what are you using to test this ? is there a simple strcpy or similar
> code you run as a kernel module that'll allow me to verify ?
> -mike
> 
Hi Mike,
yes, a simple kernel module with a init func that use strcpy or memcpy
to write over the boundaries of an local array variable is enough.
As you know, the array has to be larger than 8 bytes to match with the
gcc heuristic and generate the call to the guard.

Cheers,
Carmelo



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk0sfZIACgkQoRq/3BrK1s8kfwCeIjayIoaHapweG53icp1yoCN+
ypMAnA08chxTu49eP4QYTQU8UzO4PVpp
=ysi4
-----END PGP SIGNATURE-----

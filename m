From: bgat@billgatliff.com (Bill Gatliff)
Date: Thu, 20 May 2010 12:18:06 -0500
Subject: Support Question
In-Reply-To: <AANLkTin9qYxhbKe_ZDFvPbteM6Zn1H2M5jY6mAaH_Jxu@mail.gmail.com>
References: <1274199223.1763.0.camel@ubuntu.ubuntu-domain>
	<AANLkTin9qYxhbKe_ZDFvPbteM6Zn1H2M5jY6mAaH_Jxu@mail.gmail.com>
Message-ID: <4BF56ECE.9030303@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2010 12:06 PM, Amit kumar wrote:
>
>
> Therefore I don;t have any idea from where the delay is being
> introduced. Is it a problem of OS or there is nythng else involved .
> Kindly guide me through this . I need urgent help .... any information
> abt delay is welcome.

The SPI drivers usually have a kernel thread to deal with transmissions 
and chip selects.  Make sure that kernel thread is on the RT scheduler, 
otherwise it gets prioritized along with user applications--- which 
would explain the delay you are seeing.


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com

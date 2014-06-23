From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 23 Jun 2014 18:53:03 +0200
Subject: [PATCH V2 0/2] Sound support for Exynos4412 Odroid X2, U3 board
In-Reply-To: <53A856AE.1030202@samsung.com>
References: <1403108551-25058-1-git-send-email-s.nawrocki@samsung.com>
 <CAD8Lp44h6zc2Rt2MGLjhmNG-YB0kYCWf5G7hX5JmdmBfc1PvKg@mail.gmail.com>
 <53A856AE.1030202@samsung.com>
Message-ID: <53A85B6F.9090809@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/06/14 18:32, Sylwester Nawrocki wrote:
> On 23/06/14 11:40, Daniel Drake wrote:
>> > I tested ODROID-U2's 3.5mm analog headphone jack output with:
>> > 
>> > # speaker-test -c 2 -t wav -l 2
>> > 
>> > On my x86 laptop this command takes ~6 seconds and produces audible output:
>> > "Front left, front right, front left, front right"
>> > 
>> > When those words are reproduced over the speakers, there is a
>> > corresponding message printed to stdout which synchronizes nicely.
>> > 
>> > On ODROID-U2 the same command doesn't work quite right - execution
>> > takes only 3.5 seconds and the audible output is truncated:
>> > "Front left, front right, front"
>> > and the stdout messages do not really coincide with the audio being
>> > reproduced at that time.

Is it still wrong when you set the period manually to 1024, i.e.

# speaker-test -c 2 -t wav -l 2 -p 1024

?

--
Thanks,
Sylwester
